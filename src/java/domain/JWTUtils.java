package domain;

import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;
import java.security.Key;
import io.jsonwebtoken.*;
import java.util.Date;
import io.jsonwebtoken.Jwts;

public class JWTUtils {
    private static String SECRET_KEY = "oeRaYY7Wo24sDqKSX3IM9ASGmdGPmkTd9jo1Q4L3o4cVREf9cUsprCRK93w";
    
    public static String createJWT(String subject, Integer id, String email, 
            String username, String encryptedPass, long ttlMillis) {

        //The JWT signature algorithm we will be using to sign the token
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;

        long nowMillis = System.currentTimeMillis();
        Date now = new Date(nowMillis);

        //We will sign our JWT with our ApiKey secret
        byte[] apiKeySecretBytes = DatatypeConverter.parseBase64Binary(SECRET_KEY);
        Key signingKey = new SecretKeySpec(apiKeySecretBytes, signatureAlgorithm.getJcaName());

        //Let's set the JWT Claims
        JwtBuilder builder = Jwts.builder().setIssuedAt(now)
                .setSubject(subject)
                .setId(Integer.toString(id))
                .claim("username", username)
                .claim("email", email)
                .claim("encryptedPass", encryptedPass)
                .signWith(signatureAlgorithm, signingKey);

        //if it has been specified, let's add the expiration
        if (ttlMillis > 0) {
            long expMillis = nowMillis + ttlMillis;
            Date exp = new Date(expMillis);
            builder.setExpiration(exp);
        }  

        //Builds the JWT and serializes it to a compact, URL-safe string
        return builder.compact();
    }
    
    public static Claims decodeJWT(String jwt) {
        //This line will throw an exception if it is not a signed JWS (as expected)
        Claims claims = Jwts.parser()
            .setSigningKey(DatatypeConverter.parseBase64Binary(SECRET_KEY))
            .parseClaimsJws(jwt).getBody();
        return claims;
    }
    
    public static void main(String[] args){
        String jwt = createJWT("forgetPassword", 1/*UserId*/, "ganhj99@gmail.com", "ganhj99", "IDNWAD894nd8aydh8HUh8H8dh8H8h8dH8JDHiwhd8HD8hwd8h8DHw8h6FDvw6d7fa7d", 3600000); //3600000ms = 1 hour
        System.out.println("JWT = " + jwt);
        
        Claims claims = decodeJWT(jwt);
        System.out.println("issued at: " + claims.getIssuedAt());
        System.out.println("subject: " + claims.getSubject());
        System.out.println("id: " + claims.getId());
        System.out.println("username: " + claims.get("username", String.class));
        System.out.println("email: " + claims.get("email", String.class));
        System.out.println("encryptedPass: " + claims.get("encryptedPass", String.class));
        System.out.println("exp: " + claims.getExpiration());
        
        try{
            SendMail.send("ganhj99@gmail.com", "Email Verification / Forget Password", "This is an email message (body)");
        } catch (Throwable ex) {
            ex.printStackTrace();
        }
    }
}
// Call the dataTables jQuery plugin
$(document).ready(function() {
  $('#dataTable').DataTable( {
  "aLengthMenu": [ 5, 10, 25 ],
  "order": [[1, "desc"]], //start from 0 (index)
  });
  
  $('#dataTable2').DataTable( {
  "aLengthMenu": [ 5, 10, 25 ],
  "order": [[1, "desc"]], //start from 0 (index),
  "columns": [
    { "orderable": false,
      "className": "text-center" 
    },
    null,
    { "orderable": false }
  ],
  });
  
  $('#dataTable3').DataTable( {
  "aLengthMenu": [ 3, 5, 7 ],
  "order": [[1, "asc"]], //start from 0 (index),
  "columns": [
    { "orderable": false,
      "className": "text-center" 
    },
    { "orderable": false,
    },
    { "orderable": false }
  ],
  });
  
  $('#dataTable-orderH-sucess').DataTable( {
  "aLengthMenu": [ 5, 10, 25 ],
  "order": [[1, "desc"]], //start from 0 (index)
  "columns": [
      null,
      null,
      null,
      { "orderable": false,
        "className": "text-center" }
  ]
  });
  
  $('#dataTable-orderH-cancel').DataTable( {
  "aLengthMenu": [ 5, 10, 25 ],
  "order": [[1, "desc"]], //start from 0 (index)
  });
  
});


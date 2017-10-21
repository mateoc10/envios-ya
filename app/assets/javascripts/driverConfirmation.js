document.all.getElementById("appro").click(function approve() {
        
        $.ajax({
          url: '/admins/approve',
          headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
           data: { 
             
           },
          type: 'POST'
        }).done(function (response) {
          console.log('envio');
        }).fail(function (response) {
          console.log('marcho');
        });
      })
      
      
document.all.getElementById("appro").click(function reject() {
        
        $.ajax({
          url: '/admins/reject',
          headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
           data: { 
             
           },
          type: 'POST'
        }).done(function (response) {
          console.log('envio');
        }).fail(function (response) {
          console.log('marcho');
        });
      })
$(document).ready(function() {

  $("button.above-ten").click(function(){
    $(".overten").toggle("slow");
    if ($(this).text() == "Show Top 50") 
    { 
      $(this).text("Hide Top 50"); 
    } 
  	else 
  	{ 
     $(this).text("Show Top 50"); 
  	}; 
  });
  
});

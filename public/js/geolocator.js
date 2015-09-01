// $(document).ready(function() {
//   var geoLat;
//   var geoLong;
//
//   getCoordinates();
//
//   function getCoordinates() {
//     // File that founds out the person's location for tweets
//     $.getJSON("http://www.telize.com/geoip?callback=?", function(json) {
//     })
//     .fail(function(jqxhr, textStatus, error) {
//       var err = textStatus + ", " + error;
//       console.log("Request Failed: " + err);
//     })
//     .done(function(json) {
//       zipCode = json.postalCode;
//       geoLat  = json.latitude;
//       geoLong = json.longitude;
//
//       initMap();
//     })
//     .always(function() {
//       console.log('Search complete');
//     });
//   }
// });

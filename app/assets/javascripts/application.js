// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require morris.js06
//= require raphael
//= require turbolinks
//= require quagga
//= require_tree .

function order_by_occurrence(arr) {
  var counts = {};
  arr.forEach(function(value){
    if(!counts[value]) {
        counts[value] = 0;
    }
    counts[value]++;
  });

  var sortable = [];
  Object.keys(counts).forEach(upc => sortable.push([upc, counts[upc]]));
  sortable.sort((a,b) => a[1] < b[1] ? 1 : -1);
  return sortable[0];
}

function load_quagga(){
  if ($('#barcode-scanner').length > 0 && navigator.mediaDevices && typeof navigator.mediaDevices.getUserMedia === 'function') {

    var last_result = [];
    if (Quagga.initialized == undefined) {
      Quagga.onDetected(function(result) {
        var last_code = result.codeResult.code;
        last_result.push(last_code);
        if (last_result.length > 20) {
          code = order_by_occurrence(last_result)[0];
          last_result = [];
          $.ajax({
            type: "POST",
            url: '/foods',
            data: { upc: code }
          });
          Quagga.stop();
        }
      });
    }

    Quagga.init({
      inputStream : {
        name : "Live",
        type : "LiveStream",
        numOfWorkers: navigator.hardwareConcurrency,
        target: document.querySelector('#barcode-scanner')
      },
      decoder: {
          readers : ['ean_reader','ean_8_reader','code_39_reader','code_39_vin_reader','codabar_reader','upc_reader','upc_e_reader']
      }
    },function(err) {
        if (err) { console.log(err); return }
        Quagga.initialized = true;
        Quagga.start();
    });

  }
};

$(document).on('turbolinks:load', load_quagga);

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")


import 'bootstrap';
import "bootstrap-datepicker";
import "../stylesheets/application";

document.addEventListener("turbolinks:load", () => {
    $('[data-toggle="tooltip"]').tooltip()
    $('[data-toggle="popover"]').popover()
});

document.addEventListener("turbolinks:load", function() {

    $('#exampleModalLong').modal('show')
    $('#alert_modal').modal('hide');
    $(".loading_screen-spinner").fadeOut(1000);
    
    $('.img-choose').click(function(e){ 
        $(".border-secondary")[0].className = "img-choose img-choose-size";
        $("#"+e.target.id).attr('class', 'img-choose-size border border-secondary');
        $("#imageshow").attr("src", e.target.src);
        $("#imageshow2").attr("src", e.target.src);
    });

    $('#start_date').datepicker({
        format: 'dd/mm/yyyy'
    });
    $('#end_date').datepicker({
        format: 'dd/mm/yyyy'
    });

    $('#start_date').change(function(e){
        invoices_history()
    });
 
     $('#end_date').change(function(e){
         invoices_history()
    });
 
    $('#filter').change(function(e){
        var is_history = document.getElementById('is_history').getAttribute('value');
        if(is_history == "") {
            invoices()
        }else {
            invoices_history()
        }
    });
 
    $('#dc_route_code').change(function(e){
        suspect_invoices()
    });

    $('#invoice_date').change(function(e){
        suspect_invoices()
    });

    $('#status').change(function(e){
        suspect_invoices()
    });

    $('#ocr_status').change(function(e){
        suspect_invoices()
    });

    $("#search").click(function(e){
        var word = $('#word')[0].value;
        Turbolinks.visit("search_invoices?word=" + word)
    });
 
    function suspect_invoices() {
        var is_history             = document.getElementById('is_history').getAttribute('value');
        var filter                 = document.getElementById('filter').getAttribute('value');
        var distribution_center_id = document.getElementById('distribution_center_id').getAttribute('value');
        var dc_route_code          = $('#dc_route_code')[0].value;
        var invoice_date           = $('#invoice_date')[0].value;
        var status                 = $('#status')[0].value;
        var ocr_status             = $('#ocr_status')[0].value;

        if(is_history == "") {
            var ocr_date = document.getElementById('ocr_date').getAttribute('value');
            
            Turbolinks.visit("suspect_invoices?distribution_center_id=" + distribution_center_id + "&ocr_date=" + ocr_date + "&filter=" + filter +"&dc_route_code=" + dc_route_code + "&invoice_date=" + invoice_date + "&status=" + status + "&ocr_status=" + ocr_status)
        }else {
            var start_date = document.getElementById('start_date_params').getAttribute('value');
            var end_date   = document.getElementById('end_date_params').getAttribute('value');

            Turbolinks.visit("suspect_invoices_history?distribution_center_id=" + distribution_center_id + "&start_date=" + start_date + "&end_date=" + end_date + "&filter=" + filter +"&dc_route_code=" + dc_route_code + "&invoice_date=" + invoice_date + "&status=" + status + "&ocr_status=" + ocr_status)
        }
    }

    function invoices() {
        var filter     = $('#filter')[0].value;

        Turbolinks.visit("invoices?filter=" + filter)
    }

    function invoices_history() {
        var filter     = $('#filter')[0].value;
        var start_date = $('#start_date')[0].value;
        var end_date   = $('#end_date')[0].value;
        // console.log(filter)
        // console.log(start_date)
        // console.log(end_date)

        Turbolinks.visit("invoices_history?filter=" + filter + "&start_date=" + start_date + "&end_date=" + end_date)
    }

    function alert_modal(){
        var alert = $('#head_title').attr('alert');
        // console.log(alert);
        if (alert != ''){
            $('#alert_modal').modal('show');
        };

        
    };    
    alert_modal();

    function setDefault(){
       
        $('input[name="desc"]').each(function(){
            $(this).attr('disabled', '');
        });

        $('select[name="is_active"]').each(function(){
            $(this).attr('disabled', '');
        });

        $('button[name="new_reason_btn"').prop("hidden", "");

        $('div[name="edit_icon"]').each(function() {
            $(this).prop("hidden", false);
        });

        
    };

    function setScript(){

        $('input[name="desc"').on('input',function(e){
            var a = $(this).val();
            // console.log(a);
            
            if (a == ''){
                var summit_btn = $(this).closest('tr').find('button[name="summit_edit"]');
                summit_btn.attr('disabled', '');
                summit_btn.addClass("no_input");
            }
            else{
                var summit_btn = $(this).closest('tr').find('button[name="summit_edit"]');
                summit_btn.prop('disabled', false);
                summit_btn.removeClass("no_input");
            }
        });

        $('div[name="edit_icon"]').click(function(){
            $(this).parent().parent().find('input[name="desc"]').prop("disabled", false);
            $(this).parent().parent().find('select[name="is_active"]').prop("disabled", false);
            $(this).parent().parent().find('select[name="is_active"]').removeClass("hidden_arrow");
            
        
            $(this).parent().parent().parent().find('div[name="edit_icon"]').each(function() {
                $(this).attr('hidden', '');
            });
            $(this).parent().find('div[name="edit_cell"]').prop("hidden", false);
            $('button[name="new_reason_btn"').attr("hidden", "");
    
        });
    
        $('button[name="cancel_edit"]').click(function(){
            
            Turbolinks.visit(location.toString());
            
        });
    
        $('button[name="summit_edit"]').click(function(){
            $('div[name="edit_icon"]').each(function() {
                $(this).prop("hidden", false);
            });
            $(this).parent().attr('hidden', '');
            $('button[name="new_reason_btn"').prop("hidden", "");
            setDefault()

            var uid = $('table[name="reasons_table"]').attr('user_id'); 

            var reason_code = $(this).closest("tr").find('#reason_code').attr('value');
            
            var desc = $(this).closest("tr").find('input[name="desc"]').val();
            var is_active = $(this).closest("tr").find('select[name="is_active"]').val();
            var reason_type = $('table[name="reasons_table"]').attr('value'); 

            var data = {"reason_code" : reason_code, "desc": desc, 'user_id': uid, "is_active": is_active, "reason_type": reason_type, "cancel":false } 

            $.ajax({
                type: "POST",
                url: "/reason_management",
                async: false,
                data: data,
                success: function(data) {
                    // console.log(data); 
                },
                error: function() {
                    // console.log("add error");
                }
            });

        });
    }

    setScript()
    
    $('button[name="new_reason_btn"').click(function(e){
        var this_table = $('table[name="reasons_table"]');


        if (this_table.attr("value") == '0'){
            var reason_type = 'F';
        }
        else {
            var reason_type = 'T';
        }

        var new_reason_code = reason_type + ('000' +  (parseInt($(this).attr("value")) - 1)  ).slice(-2);

        var last_row = $('tbody[name="reasons_table_body"] tr:last');
        last_row.find('#reason_code').html(new_reason_code)
        last_row.find('#reason_code').attr('value', new_reason_code);

        last_row.find('#summit_cell').prop('hidden', '');
        last_row.prop('hidden', '');

        console.log(last_row);
        


        $(this).attr('hidden', '');

        $(this).parent().parent().parent().find('div[name="edit_icon"]').each(function() {
            $(this).attr('hidden', '');
        });

        $('button[name="new_reason_btn"').attr("hidden", "");
        setScript();

        
    });




    $('input[name="radio-btn"]').on('input', function(){
        var id = $(this).attr('id');
        
        if(id == "radio-invalid"){
            $('#select-invalid').prop('hidden', '');
            $('#select-valid').attr('hidden', '');

            $('#select-invalid').val('');
            $('#summit-reason-modal').attr('disabled', '')
     
        }else if(id == "radio-valid"){
            $('#select-invalid').attr('hidden', '');
            $('#select-valid').prop('hidden', '');

            $('#select-valid').val('');
            $('#summit-reason-modal').attr('disabled', '')
     
        };
    });

    $('#select-invalid').on('input', function(){
        if ( $(this).val() == ''){
            $('#summit-reason-modal').attr('disabled', '')
        }
        else{
            $('#summit-reason-modal').prop('disabled', '')
        }
    });

    $('#select-valid').on('input', function(){
        if ( $(this).val() == ''){
            $('#summit-reason-modal').attr('disabled', '')
        }
        else{
            $('#summit-reason-modal').prop('disabled', '')
        }
    });

    $('#summit-reason-modal').click(function(){

        var tr_invoice_id = $('#select-reason-modal').attr('tr_invoice_id');
        
        if ($('#radio-invalid').prop('checked')){  
            var reason_id = $('#select-invalid').val();
        }else{
            var reason_id = $('#select-valid').val();
        }
        var data = {"reason_id" : reason_id, "tr_invoice_id" : tr_invoice_id, "add_reason": true} 


        var this_url = $('#select-reason-modal').attr('this_page');
        
        $.ajax({
            type: "POST",
            url: this_url,
            async: false,
            data: data,
            success: function(data) {

                Turbolinks.visit(location.toString());
        
            },
            error: function() {

            }
        });
    });

    $('#validate_reason_btn').click(function(){
        $('#select-reason-modal').modal('show');

    });
});

 
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

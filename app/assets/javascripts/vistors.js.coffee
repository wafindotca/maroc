$ ->
  $(document).on 'input', '.search-query', ->
    $.ajax
      method: 'GET'
      url: '/vistors/search_visitor'
      data: {search_query: this.value}
      datatype: 'script'  
      
  $(document).on 'input', '.search_by_user_type', ->
    $.ajax
      method: 'GET'
      url: '/vistors/search_by_user_type'
      data: {user_type: this.value}
      datatype: 'script'
  
  $(document).on 'click', '.clear_date', ->
    $('#company_year_founded').val ''
    return

  $(document).on "focus", "[data-behaviour~='datepicker']", (e) ->
   $(this).datepicker
      format: "dd-mm-yy"
      weekStart: 1
      autoclose: true
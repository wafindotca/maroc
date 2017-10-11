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
  
  $(document).on "focus", "[data-behaviour~='datepicker']", (e) ->
   $(this).datepicker
      format: "yyyy-mm-dd"
      weekStart: 1
      autoclose: true

  $(document).on "change", "#search_by_calender", (e) ->
    $.ajax
      url: 'vistors/search_by_date'
      data: {search_by_date : $('#search_by_calender').val()}
      dataType: "script"
  

  $(document).on "click", ".yesterday_record_button", (e) ->
    $.ajax
      url: 'vistors/search_by_date'
      data: {search_by_date : $('#search_by_yesterday').val()}
      dataType: "script"

  $(document).on "click", ".tomorrow_record_button", (e) ->
    $.ajax
      url: 'vistors/search_by_date'
      data: {search_by_date : $('#search_by_tomorrow').val()}
      dataType: "script"
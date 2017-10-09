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


function render_company_preview(data, type) {
  $(`#${type}_preview`).removeClass('d-none')

  if(!data.item.id)
    $(`#${type}_preview`).addClass('d-none')
  
  $(`#${type}_name`).text(data.item.name)
  $(`#${type}_email`).text(data.item.email)
  $(`#${type}_cep`).text(data.item.cep)
  $(`#${type}_telephone`).text(data.item.telephone)
}


$(document).ready(function(e){
  $('#invested_cnpj').bind('railsAutocomplete.select', (event, data) => {
    render_company_preview(data, 'invested')
  });

  $('#investor_cnpj').bind('railsAutocomplete.select', (event, data) => {
    render_company_preview(data, 'investor')
  });

  console.log('sadwafawf')
})
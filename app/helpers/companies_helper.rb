module CompaniesHelper
  def html_down_tree(company, invested = nil)
    if company.invested_companies == []
      return "<li id='comp-#{company.id}' class='list-group-item'>"\
             "<a href='/companies/#{company.id}'>#{company.name}</a>"\
             "</li>"
    end

    tree = "<li id='comp-#{company.id}' class='list-group-item'>"
    tree += "<a href='/companies/#{invested.id}/investments-on/#{company.id}' class='participation'>#{invested.participation_percentage_on(company).round(2)}%</span>" if invested != nil
    tree += "<a href='/companies/#{company.id}'>#{company.name}</a>"
    tree += '<ul class="list-group list-group-flush nested">'

    company.unique_invested_companies_investments.map do |investments|
      sub_company = investments[0].invested
      if investments[0].anomalous == true
        tree += "<li id='comp-#{company.id}'"
        tree += " onmouseover='document.getElementById(`comp-#{sub_company.id}`).classList.add(`list-group-item-danger`)'"
        tree += " onmouseout='document.getElementById(`comp-#{sub_company.id}`).classList.remove(`list-group-item-danger`)'"
        tree += " class='list-group-item list-group-item-danger'>"
        tree += "<a href='/companies/#{sub_company.id}'>#{sub_company.name}</a>"
        tree += "<a href='/companies/#{company.id}/investments-on/#{sub_company.id}' class='participation'>#{company.participation_percentage_on(sub_company).round(2)}%</span>"
        tree += "</li>"
      else
        tree += html_down_tree(sub_company, company)
      end
    end

    tree += '</ul>'
    tree += '</li>'
    tree
  end

end

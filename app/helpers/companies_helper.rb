# frozen_string_literal: true

module CompaniesHelper
  def html_investments_tree(company, invested = nil)
    tree = "<li id='ive-comp-#{company.id}' class='list-group-item'>"
    tree += "<a href='/companies/#{invested.id}/investments-on/#{company.id}' class='participation'>#{invested.participation_percentage_on(company).round(2)}%</span>" unless invested.nil?
    tree += "<a href='/companies/#{company.id}'>#{company.name}</a>"
    tree += octicon (company.status == "active" ? "dot-fill" : "dot"), class: "comp-status".to_s
    tree += '<ul class="list-group list-group-flush nested">'

    company.unique_invested_companies_investments.each do |investments|
      sub_company = investments[0].invested
      if investments[0].anomalous == true
        tree += "<li id='comp-#{company.id}'"
        tree += " onmouseover='document.getElementById(`ive-comp-#{sub_company.id}`).classList.add(`list-group-item-danger`)'"
        tree += " onmouseout='document.getElementById(`ive-comp-#{sub_company.id}`).classList.remove(`list-group-item-danger`)'"
        tree += " class='list-group-item list-group-item-danger'>"
        tree += "<a href='/companies/#{company.id}/investments-on/#{sub_company.id}' class='participation'>#{company.participation_percentage_on(sub_company).round(2)}%</span>"
        tree += "<a href='/companies/#{sub_company.id}'>#{sub_company.name}</a>"
        tree += octicon (sub_company.status == "active" ? "dot-fill" : "dot"), class: "comp-status".to_s
        tree += "</li>"
      else
        tree += html_investments_tree(sub_company, company)
      end
    end

    tree += "</ul>"
    tree += "</li>"
    tree
  end

  def html_investors_tree(company, sub_tree = "", an = [false, nil])
    if company.investors.empty?
      tree = "<li id='ivo-comp-#{company.id}' class='list-group-item'>"
      tree += "<a href='/companies/#{company.id}'>#{company.name}</a>"
      tree += octicon (company.status == "active" ? "dot-fill" : "dot"), class: "comp-status".to_s
      tree += '<ul class="list-group list-group-flush nested">'
      tree += sub_tree
      tree += "</ul>"
      tree += "</li>"
      return tree
    end

    result = ""
    company.unique_investor_companies_investments.each do |investments|
      sub_company = investments[0].investor

      tree = "<li id='ivo-comp-#{company.id}' class='list-group-item'>"
      tree += "<a href='/companies/#{sub_company.id}/investments-on/#{company.id}' class='participation'>#{sub_company.participation_percentage_on(company).round(2)}%</span>"
      tree += "<a href='/companies/#{company.id}'>#{company.name}</a>"
      tree += octicon (company.status == "active" ? "dot-fill" : "dot"), class: "comp-status".to_s
      tree += '<ul class="list-group list-group-flush nested">'
      tree += sub_tree
      tree += "</ul>"
      tree += "</li>"

      if an[0] == true
        tree = "<li id='ivo-comp-#{an[1].id}' class='list-group-item'>"
        tree += "<a href='/companies/#{an[1].id}'>#{an[1].name}</a>"
        tree += octicon (an[1].status == "active" ? "dot-fill" : "dot"), class: "comp-status".to_s
        tree += '<ul class="list-group list-group-flush nested">'

        tree += "<li id='ivo-comp-#{company.id}' class='list-group-item'>"
        tree += "<a href='/companies/#{an[1].id}/investments-on/#{company.id}' class='participation'>#{an[1].participation_percentage_on(company).round(2)}%</span>"
        tree += "<a href='/companies/#{company.id}'>#{company.name}</a>"
        tree += octicon (company.status == "active" ? "dot-fill" : "dot"), class: "comp-status".to_s
        tree += '<ul class="list-group list-group-flush nested">'
        tree += sub_tree
        tree += "</ul>"
        tree += "</li>"

        tree += "</ul>"
        tree += "</li>"
        result += tree
        break
      end

      if investments[0].anomalous == true
        tree = "<li id='ivo-comp-#{company.id}'"
        tree += " onmouseover='document.getElementById(`ivo-comp-#{company.id}`).classList.add(`list-group-item-danger`)'"
        tree += " onmouseout='document.getElementById(`ivo-comp-#{company.id}`).classList.remove(`list-group-item-danger`)'"
        tree += " class='list-group-item list-group-item-danger'>"
        tree += "<a href='/companies/#{sub_company.id}/investments-on/#{company.id}' class='participation'>#{sub_company.participation_percentage_on(company).round(2)}%</span>"
        tree += "<a href='/companies/#{company.id}'>#{company.name}</a>"
        tree += octicon (company.status == "active" ? "dot-fill" : "dot"), class: "comp-status".to_s
        tree += "</li>"
        result += html_investors_tree(sub_company, tree, [true, company])
      else
        result += html_investors_tree(sub_company, tree)
      end
    end
    result
  end
end

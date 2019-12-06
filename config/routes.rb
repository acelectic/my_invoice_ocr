Rails.application.routes.draw do
  root to: "invoices#index"
  get "/invoices",                                                                       to: "invoices#index",                 as: "invoices"
  get "/suspect_invoice",                                                                to: "suspect_invoices#show",          as: "suspect_invoice"
  get "/suspect_invoices",                                                               to: "suspect_invoices#index",         as: "suspect_invoices"
  get "/suspect_invoices/:distribution_center_id/:ocr_date/:filter",                     to: "suspect_invoices#index",         as: "suspect_invoices_params"
  post "/suspect_invoice",                                                               to: "suspect_invoices#show",          as: "suspect_invoices_modal"
  
  get  "/invoices_history",                                                              to: "invoices_history#index",         as: "invoices_history" 
  get "/invoices_history/:start_date/:end_date",                                         to: "invoices_history#index",         as: "invoices_history_params"
  get "/suspect_invoice_history",                                                        to: "suspect_invoices_history#show",  as: "suspect_invoice_history"
  get "/suspect_invoices_history",                                                       to: "suspect_invoices_history#index", as: "suspect_invoices_history"
  get "/suspect_invoices_history/:distribution_center_id/:start_date/:end_date/:filter", to: "suspect_invoices_history#index", as: "suspect_invoices_history_params"
  post "/suspect_invoice_history",                                                       to: "suspect_invoices_history#show",  as: "suspect_invoice_history_modal"

  get "/reason_management",                                            to: "reason_management#index",          as: "reason_management"
  post "/reason_management",                                           to: "reason_management#new",          as: "reason_management_new"
  
  get "/search_invoices",                                                                to: "search_invoices#index", as: "search_invoices"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

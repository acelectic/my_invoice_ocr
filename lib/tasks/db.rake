namespace :db do

    task :initial do
        Rake::Task['db:drop'].invoke
        Rake::Task['db:create'].invoke
        Rake::Task['db:migrate'].invoke

        DistributionCenter.map_data
        DcRoute.map_data
        ItemCategory.map_data
        ItemSubCategory.map_data
        ItemUnitOfMeasure.map_data
        Item.map_data
        Customer.map_data
        CustomerStore.map_data
        MsInvoice.map_data
        MsInvoiceItem.map_data
    end
end
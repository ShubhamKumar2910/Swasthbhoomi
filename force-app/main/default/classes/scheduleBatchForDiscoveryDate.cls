global class scheduleBatchForDiscoveryDate implements Schedulable {
    global void execute(SchedulableContext sc) {
        batchForDiscoveryDate sendEmailToSales = new batchForDiscoveryDate();
        database.executebatch(sendEmailToSales);
    }
}
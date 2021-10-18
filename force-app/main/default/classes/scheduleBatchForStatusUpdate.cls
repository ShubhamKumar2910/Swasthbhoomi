global class scheduleBatchForStatusUpdate implements Schedulable{
    global void execute(SchedulableContext sc) {
        batchForStatusUpdate updateLeadStatus = new batchForStatusUpdate();
        database.executeBatch(updateLeadStatus);
    }
}
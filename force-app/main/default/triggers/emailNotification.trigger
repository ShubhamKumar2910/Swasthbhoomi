trigger emailNotification on Lead (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        sendMailNotification.sendEmailToSalesTeam(trigger.newMap, trigger.oldMap);
    }
}
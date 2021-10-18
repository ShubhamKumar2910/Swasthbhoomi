({
	doInit : function(component, event, helper) {
        debugger;
        var action = component.get("c.attachPDF");
        action.setParams({
            accId: component.get("v.recordId")
           
        });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS"){
                var serverResponse = response.getReturnValue();
                var dismissActionPanel = $A.get("e.force:closeQuickAction");
        		dismissActionPanel.fire();
            } else{
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'error',
                    message: response.getState(),
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();
            }    
        });
        $A.enqueueAction(action);	
    }
})
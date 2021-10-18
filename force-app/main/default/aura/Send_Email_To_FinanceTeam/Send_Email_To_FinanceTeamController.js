({
	doInit : function(component, event, helper) {
		 var action = component.get("c.sendEmail");
        action.setParams({
            accId: component.get("v.recordId")
           
        });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS"){
                var serverResponse = response.getReturnValue();
                var dismissActionPanel = $A.get("e.force:closeQuickAction");
        		dismissActionPanel.fire();  
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'Email sent Successfully',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'Success',
                    mode: 'pester'
        		});
                toastEvent.fire();
            }   
            else{
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'error',
                    message: response.getError()[0].message,
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
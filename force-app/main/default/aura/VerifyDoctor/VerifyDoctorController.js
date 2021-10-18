({
    doinit : function(component, event, helper) {
        debugger;
        var action = component.get("c.verificationOfDoctor");
        action.setParams({
            'doctorId':component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getReturnValue();
            if(state == "SUCCESS" ){
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'Doctor Verified',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });
                toastEvent.fire();             
                $A.get("e.force:closeQuickAction").fire(); 
                
            }
            else if(state == "Already Updated" ){
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'Doctor Already Verified',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });
                toastEvent.fire();             
                $A.get("e.force:closeQuickAction").fire(); 
            }
                else if(state == "Error"){
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
            window.location.reload();
        });
        $A.enqueueAction(action); 
    }
})
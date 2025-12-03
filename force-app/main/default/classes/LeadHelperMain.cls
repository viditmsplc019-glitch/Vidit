public class LeadHelperMain {
        public static void Triggasssin7(List<Lead> triggerNew, Map<Id, Lead> triggerNewMap, List<Lead> triggerOld, Map<Id, Lead> triggerOldMap){
        List<String> ldEmail = new List<String>();
        for (Lead ld : triggerNew) {
            if (ld.Email != null) {
                ldEmail.add(ld.Email);
            }
        }
        List<Contact>conMatch = new List<Contact>();
        if (!ldEmail.isEmpty()) {
            conMatch = [SELECT Id, Email FROM Contact  WHERE Email != null AND Email IN :ldEmail];
        }
        for (Lead ld : triggerNew) {
            if (ld.Email != null) {
                
                for (Contact con :conMatch) {
                    if (con.Email != null ) {
                        ld.addError('Email is there in Contact.');
                        break;
                    }
                }
            }
        }
        
    }

}
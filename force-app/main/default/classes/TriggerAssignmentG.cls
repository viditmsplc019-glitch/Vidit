public class TriggerAssignmentG {
    public static void Triggasssin(list<Lead>ldlst){
        List<String> ldEmail = new List<String>();
        for (Lead ld : ldlst) {
            if (ld.Email != null) {
                ldEmail.add(ld.Email);
            }
        }
        List<Contact>conMatch = new List<Contact>();
        if (!ldEmail.isEmpty()) {
            conMatch = [SELECT Id, Email FROM Contact  WHERE Email != null AND Email IN :ldEmail];
        }
        for (Lead ld : ldlst) {
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
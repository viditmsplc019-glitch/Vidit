public class CandidateHandler {
    public static void AfterInsertDelete20(list<Candidate__c>lstCandid){
    CandidateHelper.TriggerAssn20(lstCandid);
    }

}
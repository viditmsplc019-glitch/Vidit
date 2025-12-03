public class GlobalUtility {
    public static set<Id> getUniqueIds(list<Sobject>sobs){
        set<Id> Ids = new set<Id>();
        for(SObject Sob:sobs){
            Ids.add(sob.Id);
        }
        return Ids;
    }

}
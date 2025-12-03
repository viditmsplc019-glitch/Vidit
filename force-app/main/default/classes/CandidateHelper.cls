public class CandidateHelper {
    
    public static void TriggerAssn20(list<Candidate__c>lstCandi){
     Set<Id> candidateIds = new Set<Id>();
    Map<Id, String> candidateSkillTextMap = new Map<Id, String>();

    for (Candidate__c candi : lstCandi) {
        if (!String.isBlank(candi.Skills__c)) {
            candidateIds.add(candi.Id);
            candidateSkillTextMap.put(candi.Id, candi.Skills__c);
        }
    }

    if (candidateIds.isEmpty()) return;

    Set<String> allSkillNames = new Set<String>();
    for (String skillText : candidateSkillTextMap.values()) {
        for (String skill : skillText.split(',')) {
            if (!String.isBlank(skill)) {
                allSkillNames.add(skill.trim().toLowerCase());
            }
        }
    }

    
    Map<String, Skills__c> existingSkillsMap = new Map<String, Skills__c>();
    for (Skills__c skill : [ SELECT Id, Name  FROM Skills__c WHERE Name IN :allSkillNames]) {
        existingSkillsMap.put(skill.Name.toLowerCase(), skill);
    }

    
    List<Skills__c> skillInsert = new List<Skills__c>();
    for (String skillName : allSkillNames) {
        if (!existingSkillsMap.containsKey(skillName)) {
            Skills__c newSkill = new Skills__c(Name = skillName);
            skillInsert.add(newSkill);
        }
    }

    if (!skillInsert.isEmpty()) {
        insert skillInsert;
        for (Skills__c skl : skillInsert) {
            existingSkillsMap.put(skl.Name.toLowerCase(), skl);
        }
    }

    
    List<Candidate_Skill__c> candidateSkillsToInsert = new List<Candidate_Skill__c>();

    for (Candidate__c candidate : lstCandi) {
        String skillText = candidateSkillTextMap.get(candidate.Id);
        if (String.isBlank(skillText)) continue;

        Set<String> uniqueSkills = new Set<String>();
        for (String skill : skillText.split(',')) {
            String trimmedSkill = skill.trim().toLowerCase();
            if (existingSkillsMap.containsKey(trimmedSkill) && !uniqueSkills.contains(trimmedSkill)) {
                uniqueSkills.add(trimmedSkill);

                candidateSkillsToInsert.add(new Candidate_Skill__c(
                    Candidate__c = candidate.Id,
                    Skills__c = existingSkillsMap.get(trimmedSkill).Id
                ));
            }
        }
    }

    if (!candidateSkillsToInsert.isEmpty()) {
        insert candidateSkillsToInsert;
    }
    }

}
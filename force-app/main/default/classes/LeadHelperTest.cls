@isTest
public class LeadHelperTest {

    @isTest
    static void testInsertAndUpdateValidation() {
        Contact con = new Contact(LastName = 'Existing Contact', Email = 'duplicate@test.com');
        insert con;

        Lead ld1 = new Lead(LastName = 'Test Lead Insert', Company = 'Insert Test Co', Email = 'duplicate@test.com');
        try {
            insert ld1;
            System.assert(false, 'Insert should have failed due to duplicate email.');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Email is there in Contact'), 'Insert error message incorrect.');
        }

        Lead ld2 = new Lead(LastName = 'Test Lead Update', Company = 'Update Test Co', Email = 'unique@test.com');
        insert ld2;

        ld2.Email = 'duplicate@test.com';
        try {
            update ld2;
            System.assert(false, 'Update should have failed due to duplicate email.');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Email is there in Contact'), 'Update error message incorrect.');
        }
    }
}
public without sharing class ClbInsEndProcessQuote {
    @InvocableMethod(label='Create Insurance Policy')
    public static List<String> upsertProposal(List<Quote> context) {
        List<String> responseData = new List<String>();
        for(Quote objQuote : context){
            /* Initialize variables */ 
            Map<String, Object> ipOutput = (Map<String, Object> ) vlocity_ins.IntegrationProcedureService.runIntegrationService(
                'ClbIns_CreateAssetFromQuote', 
                new Map<String, Object> {'quoteId' => objQuote.Id},
            	new Map<String, Object>()
            );
            
            responseData.add((String)ipOutput.get('error'));
        }
        return responseData;
    } 
}
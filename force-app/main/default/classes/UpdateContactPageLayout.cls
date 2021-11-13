public class UpdateContactPageLayout {

    public void getAllFieldsNames() {

        Schema.SObjecttype type =Profile.sObjectType;
        List<String> result = New List<String>{};
        
        Map<String, Schema.sObjectField> omap = type.getDescribe().fields.getMap();
        for(String s: omap.keySet()) {
        //    // カスタム項目だけ選択
        //    if (s.endsWith('__c')) {
                result.add(s);
                System.debug(s);
        //    }
        }
        System.debug(String.join(result, ','));
    }

    public void showProfileNames(){
        List<Profile>  profileList = [select id , Name from Profile];
        for(Profile pf:profileList){
            System.debug(pf.Name);

        }

    }
    /**
     * レイアウトに項目を追加する
     */
    public Metadata.Layout addLayoutItem (){

        List<Metadata.Metadata> layoutsList  = Metadata.Operations.retrieve(Metadata.MetadataType.Layout, 
                                                                                 new List<String> {'Contact-Contact Layout'});
        Metadata.Layout layoutMetadata = (Metadata.Layout) layoutsList.get(0);
        
        Metadata.LayoutSection contactLayoutSection  = null;
        
        for(Metadata.LayoutSection section : layoutMetadata.LayoutSections){
            system.debug(section.label);

            //if(section.label == 'Additional Information'){
            //   contactLayoutSection = section; 
            //    break;
            //}
        }
/*        
        List<Metadata.LayoutColumn> contactColumns =  contactLayoutSection.layoutColumns ;
        List<Metadata.LayoutItem> contactLayoutItems  = contactColumns.get(0).layoutItems ;
        
        Metadata.LayoutItem newField  = new Metadata.LayoutItem();
        newField.behavior = Metadata.UiBehavior.Edit;
        newField.field = 'AMAPI__Apex_MD_API_Twitter_name__c';
        contactLayoutItems.add(newField);
*/
        return layoutMetadata;
    }
}
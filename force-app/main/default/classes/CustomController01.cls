public with sharing class CustomController01 {
    private final Account account;
    
    // コンストラクタ 
    public CustomController01() {
        system.debug('CustomController01()');
        String id = '0015h00000NvH6r';
        account = [SELECT Id, Name, Phone, Type FROM Account 
            WHERE Id = :id];
//                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
//save();
    }
    
    // 取引先レコードを取得
    public Account getAccountById() {
        return account;
    }
    
    // 保存メソッド
    public PageReference attach() {
        system.debug('attach()');
        try{
            Attachment attach = new Attachment();
            //添付先
            attach.ParentId = '0015h00000NvH6r';
            attach.Body = Page.CustomController01_try.getContent();
            attach.Name = 'Test.pdf';
            insert attach;
            return Page.CustomController01_try;
        }catch(Exception e){
            system.debug(e.getMessage());
        }
        return null;
    }
}
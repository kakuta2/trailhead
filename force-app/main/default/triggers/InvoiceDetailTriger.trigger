trigger InvoiceDetailTriger on InvoiceDetail__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	new TRG_InvoiceDetail().execute();
}
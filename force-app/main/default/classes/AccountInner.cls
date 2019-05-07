global Class AccountInner
{
    public boolean isSelected {get;set;}
    public Account acc {get;set;}
    
    public AccountInner(boolean isSelected, Account acc)
    {
        this.isSelected = isSelected;
        this.acc = acc;
    }
}
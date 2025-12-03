public class Calculate {
public integer num1,num2, result,res=100;

public integer getResult()
    {
return result;
    }
public integer getRes()
    {

return res;
    }
public integer getNum1()
    {
return num1;
    }
public integer getNum2()
    {
return num2;
    }
public void setNum1(integer n1)
    {
        num1=n1;
    }
public void setNum2(integer n1)
    {
        num2=n1;
    }
public PageReference add()
    {
result=num1+num2;
res=200;
return null;
    }
public PageReference sub()
	{
		result=num1-num2;

return null;
    }
public PageReference mul()
    {
result=num1*num2;
return null;
    }
public PageReference div()
    {
result=num1 / num2;
return null;   
    }
}
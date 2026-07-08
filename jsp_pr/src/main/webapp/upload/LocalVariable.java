package day0310;
/**
	이 class는 지역변수의 대한 학습을 위한 class 
*/
class LocalVariable 
{
	//class field : instance variable, static variable
	
	public static void main(String[] args) 
	{
		/*
		local : local variable
		1. 선언 : 데이터형 변수명;
			- 하나의 영역에서는 같은 이름의 변수를 하나만 선언 할 수 있다.
			- 변수명이 다르면 변수를 얼마든지 선언 할 수 있다.
		2. 값 할당 : 변수면 = 값;
		3. 값 사용 : 출력, 연산, 재할당
		
		
		*/
		int myAge;//선언
		myAge = 37;//초기화
		
		double myHeight = 181.1;//선언 및 초기화
		double myWeight = 120.0;
		
		int age=0,year=2026,month=3,day=10;
		System.out.println("나이 : "+age+",  연월일 : "+year+"-"+month+"-"+day);
		
		String dayData = "2026.03.10";
		System.out.println(dayData);
		
		dayData = "2026-03-10";//기존 값 위에 다른 값으로 덮어씌워서 이전 값은 사라지고 입력된 값으로 바뀐다.
		
		System.out.println(myAge);//출력
		System.out.println(myHeight);
		System.out.println(myWeight);
		System.out.println(dayData);
		//System.out.println(myAge+myHeight+myWeight);
		
		
		//참조형 데이터 형 : 주소 할당
		LocalVariable lv = new LocalVariable();
		
		System.out.println(lv);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}//main
}//class

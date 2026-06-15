package day0612;

import java.util.ArrayList;
import java.util.List;

public class TestService {

	public List<TestDTO> searchMember(){
		List<TestDTO> list = new ArrayList<TestDTO>();
		list.add(new TestDTO("박지성",26));
		list.add(new TestDTO("안정환",27));
		list.add(new TestDTO("박지성2",28));
		list.add(new TestDTO("박지성3",29));
		
		return list;
	}
	
}

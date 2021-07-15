package org.zerock.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data // setter, getter, toString(), 생성자 자동 생성하는 어노테이션
public class SampleDTOList {

	private List<SampleDTO> list;
	
	public SampleDTOList() {
		list = new ArrayList<SampleDTO>();
	}
}

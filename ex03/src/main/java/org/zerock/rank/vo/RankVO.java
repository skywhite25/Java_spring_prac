package org.zerock.rank.vo;

import java.util.Date;

import lombok.Data;

@Data
public class RankVO {
	
	private Long no;
	private String id;
	private Long score;
	private Date testDate;
	private String lev;
	
	private String title;
	private String content;
	private String fileName;
	private Date writeDate;
	
}

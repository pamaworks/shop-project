package com.prinhashop.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;


// 웹 프로젝트 외부 영역에 존재하는 파일 작업을 하기위한 유틸
public class FileUtils {
	
	// uploadPath(기본 파일 업로드 경로) -> servlet-context.xml 에서 설정
	

	// 1) ★파일 업로드 (맨 마지막에 작성-하단 메소드들을 먼저 작성해주기)
	/*
		@Params
		String uploadPath : 기본 파일 업로드 경로
		String originName : 원본 파일명
		byte[] fileData : 파일 데이터
		
		@return
		String uploadedFileName : 업로드 파일명 /날짜경로 + 파일이름 (ex.\\2020\\03\\13\\uuid+fileName)
	*/
	public static String uploadFile(String uploadPath, String originName, byte[] fileData)throws Exception{
		
		System.out.println("-- 파일 업로드");
		
		// 1. 파일명 설정 / uuid_원본파일명 -> 파일명 중복 방지
		UUID uuid = UUID.randomUUID();
		String savedName = uuid.toString()+"_"+originName;
		
		// 2. 파일 경로 설정 / 날짜경로
		String savedPath = calcPath(uploadPath);
		
		// 3. 설정한 정보로 빈 파일 생성
		// uploadPath + savedPath (기본경로+날짜경로)
		// savedName (uuid + 원본파일명)
		File target = new File(uploadPath + savedPath,savedName);
		
		// 4. 만들어놓은 빈 파일에 이미지 데이터 복사
		FileCopyUtils.copy(fileData, target);
		
		// -----------------------------------------------------
		
		// 확장자명만 가져오기
		String formatName = originName.substring(originName.lastIndexOf(".")+1);
		
		// 최종 업로드할 파일명 생성
		String uploadFileName = null;
		
		// 확장자명(formatName)으로 이미지 파일인지? 일반 파일인지 확인
		if(MediaUtils.getMediaType(formatName)!=null) { // 이미지 파일
			uploadFileName = makeThumNail(uploadPath, savedPath, savedName);
		}else { // 일반 파일이면, 아이콘 생성
			uploadFileName = makeIcon(uploadPath, savedPath, savedName);
		}

		return uploadFileName;
	}

	
	
	// 2) 날짜 폴더 경로 설정
	/*
		@Params
		uploadPath : 기본 파일 업로드 경로
		
		@return
		datePath : 생성된 날짜 폴더 경로 \\2020\\12\\25
	*/
	private static String calcPath(String uploadPath) {
	
		Calendar cal = Calendar.getInstance();
		
		// 년/월/일 형태의 날짜 경로
		// File.separator : 파일 경로 구분자 / \ -> 운영체제에 상관없이 구분
		
		// 년  \\2020
		String yearPath = File.separator+cal.get(Calendar.YEAR);
		
		// 년+월  \\2020\\12
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		
		// 년+월+일  \\2020\\12\\25
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		System.out.println("-- calcPath result : "+datePath);
		
		// 경로별 모든 폴더 생성
		makeDir(uploadPath,yearPath,monthPath,datePath);
		
		return datePath;
	}

	

	// 3) 폴더 생성
	/*
	  	@Params
	  	String uploadPath : 기본 파일 업로드 경로
	  	String ... paths : 생성할 폴더 경로들(날짜)
	*/
	private static void makeDir(String uploadPath, String ... paths) {

		// 가장 마지막 매개변수의 폴더가 존재하는지 확인하고 -> 존재하면 return
		if(new File(paths[paths.length-1]).exists()) {
			return;
		}
		
		// 매개변수로 들어온 경로의 모든 폴더 생성
		for(String path : paths) {
			File dirPath = new File(uploadPath+path);
			
			// 해당 폴더가 존재하지않으면 폴더 생성
			if(!dirPath.exists()) {
				dirPath.mkdir(); // 폴더 생성
			}
		}
	}
	
	
	
	// 4) 이미지 파일 썸네일 생성
	/*
	 	@Params
	 	String uploadPath : 기본 파일 업로드 경로
	 	String path : 날짜 경로
	 	String fileName : UUID_originName / uuid+원본파일명
	 	
	 	@return
	 	String : 날짜경로+s_+fileName
	 	\\2020\\12\\25\\uuid+s_+fileName
	 	
	 	s_  ->  썸네일
	*/
	private static String makeThumNail(String uploadPath, String path, String fileName)throws Exception{
		
		// 소스 이미지(원본) 가져오기
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath+path,fileName));
		
		// 썸네일 높이를 300px로 하고 width를 height에 맞춤
		BufferedImage thumbImage = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,300);
		
		// 썸네일 생성 준비 
		// 썸네일명 = 기본경로 + 날짜경로 + s_ + (uuid_원본파일명)
		String thumNailName = uploadPath + path + File.separator + "s_" + fileName;
		
		// 새로운 파일 생성 (썸네일 이미지)
		File newFile = new File(thumNailName);
		// 확장자명
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
		// 썸네일 생성
		ImageIO.write(thumbImage, formatName.toUpperCase(), newFile);
		
		// 생성한 썸네일 경로의 subString을 반환
		System.out.println("썸네일 이미지명 : "+thumNailName);		
		return thumNailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	

	
	/*
	 
public String makeThumbnail(int thumbnail_height){ //높이 비율로 가로를 조정
   String thumbnailName = null;
   if(newFileFlag){
     try{
        BufferedImage originImage = ImageIO.read(newFile);
        thumbnailName="thumb_"+newFilename;
        thumbFile = new File(savePath,thumbnailName);
        
        if(!(originImage.getHeight()<=thumbnail_height)){
           //Scalr 라이브러리 : 그리는 과정을 resize로 생략해줌
           BufferedImage thumbImage = Scalr.resize(originImage, Scalr.Method.QUALITY, Mode.FIT_TO_HEIGHT, thumbnail_height);
           ImageIO.write(thumbImage, extension, thumbFile);
        }else{//이미 파일이 썸네일보다 작을 때 그냥 복사한다.
           byte[] newFiledata = FileCopyUtils.copyToByteArray(newFile);
           FileCopyUtils.copy(newFiledata, thumbFile);
        }
     }catch(Exception e){e.printStackTrace();}
   }
   return thumbnailName;
}
	  
	 */
	
	
	

	// 5) 확장자명이 일반파일일 경우, 아이콘생성
	/*
	 	@Params
	 	String uploadPath : 기본 파일 업로드 경로
	 	String path : 날짜 경로
	 	String fileName : UUID_originName / uuid+원본파일명
	 	
	 	@return
	 	String : 날짜경로+s_+fileName
	 	\\2020\\12\\25\\uuid+s_+fileName
	*/
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception{
		
		String iconName = uploadPath + path + File.separator + fileName;
		
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	
	
	
	// 6) 외부 파일 가져오기
	/*
	  	웹 프로젝트 외부 영역의 파일을 가져와 ResponseEntity로 반환
	  	
	  	@Params
	  	String uploadPath : 외부 폴더 업로드 경로
	  	String fileName : 가져올 파일명
	  	
	  	@return
	  	ResponseEntity<byte[]> : 가져온 파일 정보와 Http 상태코드 반환
	  	
	*/
	public static ResponseEntity<byte[]> getFile(String uploadPath, String fileName)throws Exception{
		
		InputStream in = null;
		byte[] fileData = null; // 가져올 파일명
		ResponseEntity<byte[]> entity = null;
		
		try {
			// 파일의 확장자로 파일 종류 확인
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType type = MediaUtils.getMediaType(formatName);
			
			// Http헤더에 콘텐츠타입(확장자) 세팅
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(type);
			
			// 해당 파일 가져오기
			in = new FileInputStream(uploadPath + fileName);
			
			// entity
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			in.close(); // InputStream 닫아주기
		}
	
		return entity;
	}
	
	
	
	// 7) 이미지파일 삭제
	/*
	  	@Params
	  	String uploadPath : 파일 경로
	  	String fileName : 삭제할 파일명
	*/
	public static void deleteFile(String uploadPath, String fileName) {
		
		String front  = fileName.substring(0,12); // 날짜 경로
		String end = fileName.substring(14); // UUID_fileName
		
		String origin = front+end;
	
		new File(uploadPath+origin.replace('/', File.separatorChar)).delete();
		new File(uploadPath+fileName.replace('/', File.separatorChar)).delete();
	}
	
	
	
	// 8) 썸네일 파일명->원래파일명으로 
	public static String thumbToOriginName(String thumNailName) {
		String front = thumNailName.substring(0,12); // 날짜 경로
		String end = thumNailName.substring(14); // UUID_fileName
		
		return front+end;
	}
	
}

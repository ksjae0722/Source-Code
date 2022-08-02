package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import mvc.database.DBConn;
import mvc.model.BoardDTO;
import mvc.model.ssubjectDTO;

public class BoardDAO
	{
	int index;
	
	private JdbcTemplate jdbcTemplate;
	
	public BoardDAO(DataSource dataSource)
		{
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		}

	/*총 게시글이 몇개인지 가져오는 메서드*/
	public int getListCount(String subjects)
		{
		Integer results;
		
		if((subjects == null) || (subjects.equals("sub_all")))
			{
			results = jdbcTemplate.queryForObject("select count(*) from post", Integer.class);
			}
		
		else
			{
			results = jdbcTemplate.queryForObject("select count(*) from post where sub_name=?", Integer.class, subjects);
			}
		
		return results;
		}
	
	/*db에 저장된 게시글의 모든 정보를 가져오는 메서드, 어레이리스트*/
	public ArrayList<BoardDTO> getBoardList(int page, int limit, String subjects)
		{
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		
		int TotalOfPost = getListCount(subjects);
		int end = (page -1) * limit;
		index = TotalOfPost-end; //두번째 페이지는 11번째 게시글부터 출력

		List<ArrayList<BoardDTO>> results;
		
		if((subjects == null)||(subjects.equals("sub_all")))
			{
			results
			= jdbcTemplate.query
				("select * from post ORDER BY po_num DESC",
				new RowMapper<ArrayList<BoardDTO>>()
					{
					@Override
					public ArrayList<BoardDTO> mapRow(ResultSet rs, int rowNum) throws SQLException
						{
						do
							{
							if (rs.getInt("po_num") != index)
								{
								continue;
								}
							BoardDTO board = new BoardDTO();
							board.setPo_num(rs.getInt("po_num"));
							board.setPo_subject(rs.getString("po_subject"));
							board.setPo_date(rs.getString("po_date"));
							board.setSub_name(rs.getString("sub_name"));
							board.setP_oNumber(("p_oNumber"));
							board.setN_contents(rs.getString("n_contents"));
							board.setP_name(rs.getString("p_name"));
							board.setP_id(rs.getString("p_id"));
							list.add(board);
							
							if(index > TotalOfPost-end-9)
								{
								index--;
								}
							else
								{	
								break;
								}
							} while(rs.next());

						return list;
						}
					}
				);
			}
		
		else
			{
			results
			= jdbcTemplate.query
				("select * from post where sub_name=? ORDER BY po_num DESC",
				new RowMapper<ArrayList<BoardDTO>>()
					{
					@Override
					public ArrayList<BoardDTO> mapRow(ResultSet rs, int rowNum) throws SQLException
						{
						do
							{
							if (rs.getInt("po_num") != index)
								{
								continue;
								}
						
							BoardDTO board = new BoardDTO();
							board.setPo_num(rs.getInt("po_num"));
							board.setPo_subject(rs.getString("po_subject"));
							board.setPo_date(rs.getString("po_date"));
							board.setSub_name(rs.getString("sub_name"));
							board.setP_oNumber(("p_oNumber"));
							board.setN_contents(rs.getString("n_contents"));
							board.setP_name(rs.getString("p_name"));
							board.setP_id(rs.getString("p_id"));
							list.add(board);
							
							if(index > TotalOfPost-end-9)
								{
								index--;
								}
							else
								{	
								break;
								}
							} while(rs.next());

						return list;
						}
					},
				subjects
				);
			}
		
		return results.isEmpty() ? null : results.get(0);
		}

	/*db에서 내 과목 가져오는 메서드*/
	public ArrayList<String> getmySubject(String id)
		{
		ArrayList<String> sub_list = new ArrayList<String>();
		
		List<ArrayList<String>> results
		= jdbcTemplate.query
			("select * from ssubject where p_id=?",
			new RowMapper<ArrayList<String>>()
				{
				@Override
				public ArrayList<String> mapRow(ResultSet rs, int rowNum) throws SQLException
					{
					do
						{
						sub_list.add(rs.getString("sub_name"));
						} while (rs.next());
					
					return sub_list;
					}
				},
			id
			);
		
		return results.isEmpty() ? null : results.get(0);
		}
	
	/*작성글 DB에 등록하기*/
	public void insertBoard(BoardDTO board)  {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConn.getConnection();		

			String sql = "insert into post(po_subject, po_date, sub_name, p_oNumber, n_contents, p_name, p_id, po_filename, po_realname) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
			//board에 값 삽입
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getPo_subject());
			pstmt.setString(2, board.getPo_date());
			pstmt.setString(3, board.getSub_name());
			pstmt.setString(4, board.getP_oNumber());
			pstmt.setString(5, board.getN_contents());
			pstmt.setString(6, board.getP_name());
			pstmt.setString(7, board.getP_id());
			pstmt.setString(8, board.getPo_filename());
			pstmt.setString(9, board.getPo_realname());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertBoard() 에러 : " + ex);
		} finally {
			try {									
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}		
	} 

	/*선택된 글 DB에서 상세 내용 가져오기*/
	public BoardDTO getBoardByNum(int num)
		{
		List<BoardDTO> results
		= jdbcTemplate.query
			("select * from post where po_num = ?",
			new RowMapper<BoardDTO>()
				{
				@Override
				public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException
					{
					BoardDTO b_dto = new BoardDTO();
					
					b_dto.setPo_num(rs.getInt("po_num"));
					b_dto.setPo_subject(rs.getString("po_subject"));
					b_dto.setPo_date(rs.getString("po_date"));
					b_dto.setSub_name(rs.getString("sub_name"));
					b_dto.setP_oNumber(rs.getString("p_oNumber"));
					b_dto.setN_contents(rs.getString("n_contents"));
					b_dto.setP_name(rs.getString("p_name"));
					b_dto.setP_id(rs.getString("p_id"));
					b_dto.setPo_filename(rs.getString("po_filename"));
					b_dto.setPo_realname(rs.getString("po_realname"));
					
					return b_dto;
					}
				},
			num
			);
		
		return results.isEmpty() ? null:results.get(0);
		}
	
	/*선택된 글 삭제*/
	public void deleteBoard(int num)
		{
		jdbcTemplate.update("delete from post where po_num=?", num);
		}
	
	/*선택된 글 내용 업데이트*/
	public void updateBoard(BoardDTO board) {

		Connection conn = null;
		PreparedStatement pstmt = null;
	
		try {
			String sql = "update post set sub_name=?, po_subject=?, po_filename=?, n_contents=?, po_date=?, po_realname=? where po_num=?";
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			conn.setAutoCommit(false); //사용자가 직접 commit/rollback

			pstmt.setString(1, board.getSub_name());
			pstmt.setString(2, board.getPo_subject());
			pstmt.setString(3, board.getPo_filename());
			pstmt.setString(4, board.getN_contents());
			pstmt.setString(5, board.getPo_date());
			pstmt.setString(6, board.getPo_realname());
			pstmt.setInt(7, board.getPo_num());

			pstmt.executeUpdate();			
			conn.commit();

		} catch (Exception ex) {
			System.out.println("updateBoard() 에러 : " + ex);
		} finally {
			try {										
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
	}
	}

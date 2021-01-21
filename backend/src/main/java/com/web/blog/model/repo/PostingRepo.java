package com.web.blog.model.repo;

import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import com.web.blog.model.dto.Posting;

@Repository
public interface PostingRepo {
	public Posting select(int pid) throws SQLException;
	public Posting[] selectListAll(int pageSt, int pageFin) throws SQLException;
	public Posting[] selectListAllTag(int pageSt, int pageFin, String tag) throws SQLException;
	public Posting[] selectListName(int pageSt, int pageFin, String name) throws SQLException;
	public Posting[] selectListNameTag(int pageSt, int pageFin, String name, String tag) throws SQLException;
	public Posting[] selectListTitle(int pageSt, int pageFin, String title) throws SQLException;
	public Posting[] selectListTitleTag(int pageSt, int pageFin, String title, String tag) throws SQLException;
	public Posting[] selectListContent(int pageSt, int pageFin, String content) throws SQLException;
	public Posting[] selectListContentTag(int pageSt, int pageFin, String content, String tag) throws SQLException;
	public int insert(Posting posting) throws SQLException;
	public int update(Posting posting) throws SQLException;
	public int delete(int pid) throws SQLException;
}

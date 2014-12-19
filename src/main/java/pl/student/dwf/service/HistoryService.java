package pl.student.dwf.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pl.student.dwf.entity.History;
import pl.student.dwf.repository.HistoryRepository;

@Service
@Transactional
public class HistoryService {

	@Autowired
	private HistoryRepository historyRepository;
	
	public List<History> findAll() {
		return historyRepository.findAll();
	}
}

package com.giljobe.company.model.service;

import java.sql.Connection;


public class CompanyService {
	private static final CompanyService SERVICE = new CompanyService();
	private CompanyService() {}
	public static CompanyService companyService() {
		return SERVICE;
	}
	private CompanyService comDao = CompanyService.companyService();
	private Connection conn;
}

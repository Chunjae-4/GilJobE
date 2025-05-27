package com.giljobe.program.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProTime {
    private int timeNo;
    private Date startTime;
    private Date endTime;
    private Round roundNoRef;
}

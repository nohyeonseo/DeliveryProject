package com.project.domain;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderAddDTO 
{
    private long o_number;
    private long m_id;
    private long a_id;
    private int a_number;
    private double a_price;
}

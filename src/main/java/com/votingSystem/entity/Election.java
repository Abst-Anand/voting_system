package com.votingSystem.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.util.Date;

@Entity
public class Election {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int electionId;
    private String electionName;
    private String electionType;
    private Date startDate;
    private Date endDate;
    private int assingedTo;
    private int createdBy;

    public Election() {
        super();
    }

    public Election(String electionName, String electionType, Date startDate, Date endDate, int assingedTo, int createdBy) {
        super();
        this.electionName = electionName;
        this.electionType = electionType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.assingedTo = assingedTo;
        this.createdBy = createdBy;
    }

    public Election(int electionId,String electionName, String electionType, Date startDate, Date endDate, int assingedTo, int createdBy) {
        super();
        this.electionId = electionId;
        this.electionName = electionName;
        this.electionType = electionType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.assingedTo = assingedTo;
        this.createdBy = createdBy;
    }

    public int getElectionId() {
        return electionId;
    }

    public String getElectionName() {
        return electionName;
    }

    public String getElectionType() {
        return electionType;
    }

    public Date getStartDate() {
        return startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public int getAssingedTo() {
        return assingedTo;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setElectionId(int electionId) {
        this.electionId = electionId;
    }

    public void setElectionName(String electionName) {
        this.electionName = electionName;
    }

    public void setElectionType(String electionType) {
        this.electionType = electionType;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public void setAssingedTo(int assingedTo) {
        this.assingedTo = assingedTo;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    @Override
    public String toString() {
        return "\nElection{" +
                "electionId=" + electionId +
                ", electionName='" + electionName + '\'' +
                ", electionType='" + electionType + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", assingedTo=" + assingedTo +
                ", createdBy=" + createdBy +
                '}';
    }
}
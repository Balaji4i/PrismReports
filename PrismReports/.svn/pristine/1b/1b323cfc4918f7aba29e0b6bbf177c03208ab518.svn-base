/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.omniyat.report;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import javax.xml.parsers.ParserConfigurationException;
import oracle.xdo.XDOException;
import oracle.xdo.template.FOProcessor;
import oracle.xdo.template.RTFProcessor;

/**
 * REST Web Service
 *
 * @author gautham.r
 */
@Path("/project")
public class PrismProject {
//public final int p_bu_id = 1;
    @Context
    private UriInfo context;
    InvokeReport invrep = new InvokeReport();
    DbPackageCall dbPackageCall = new DbPackageCall();

    /**
     * Creates a new instance of FcrReport
     */
    public PrismProject() {
    }

    /**
     * Retrieves representation of an instance of com.omniyat.fcr.FcrReport
     * @param p_bu_id
     * @param p_status
     * @param P_File_Type
     * @param p_date
     * @return an instance of java.lang.String
     */
    @Path("/summary")
    @GET
    @Produces(MediaType.APPLICATION_OCTET_STREAM)
    public Response prismProject(
            @QueryParam(value = "p_bu_id") long p_bu_id,
           @QueryParam(value = "p_status") String p_status,
            @QueryParam(value = "P_File_Type") String P_File_Type,
            @QueryParam(value = "p_date") String p_date) throws ParserConfigurationException, ParseException, SQLException, NamingException, ClassNotFoundException{
//        System.out.println("id : "+p_bu_id +"\n project id : "+p_project_id+"\n p_date :"+p_date);
         String fileName = "";
        if(P_File_Type.equals("pdf")){
        fileName = p_bu_id +".pdf";
        }
        else{
        fileName = p_bu_id +".xlsx";
        }
        SimpleDateFormat parser = new SimpleDateFormat("dd-MM-yyyy");
        Date date = parser.parse(p_date);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
        String dateParam = formatter.format(date);
        SimpleDateFormat pkgFormatter = new SimpleDateFormat("dd-MMM-yy");
        String dateFormat = pkgFormatter.format(date);
//        System.out.println("Date--"+dateParam);
//        invrep.projectSummary(p_bu_id,p_status,dateFormat);
        invrep.projectSummary(p_bu_id,p_status,dateParam);
       // String fileName = p_bu_id + ".xlsx";
        String xmlData = dbPackageCall.prismProject(p_bu_id,p_status,dateFormat);
        String filePath = "/u01/data/reports/Project Summary Report.rtf";
        ResponseBuilder builder = Response.ok(prismProject(xmlData, filePath,P_File_Type));
        builder.header("Content-Disposition", "attachment; filename=" + fileName);
        return builder.build();
    }

    public byte[] prismProject(String xmlData, String filePath, String fileType) {
        InputStream fiS = null;
        ByteArrayInputStream xslInStream = null;
        ByteArrayInputStream dataStream = null;
        ByteArrayOutputStream pdfOutStream = null;

        byte[] dataBytes = null;
        byte outFileTypeByte = 0;
        try {

            fiS = new FileInputStream(new File(filePath));
            if(fileType.equals("pdf")){
                 outFileTypeByte = FOProcessor.FORMAT_PDF;
             }
             else{
               outFileTypeByte = FOProcessor.FORMAT_XLSX;
             }

            RTFProcessor rtfP = new RTFProcessor(fiS); 
            ByteArrayOutputStream xslOutStream = new ByteArrayOutputStream();
            rtfP.setOutput(xslOutStream);
            rtfP.process();
            xslInStream = new ByteArrayInputStream(xslOutStream.toByteArray());

            FOProcessor processor = new FOProcessor();
//            processor.setConfig("/u01/data/font/xdo.cfg");
            dataStream = new ByteArrayInputStream(xmlData.getBytes());

            processor.setData(dataStream);
            processor.setTemplate(xslInStream);

            pdfOutStream = new ByteArrayOutputStream();
            processor.setOutput(pdfOutStream);

            processor.setOutputFormat(outFileTypeByte);
            processor.generate();
            dataBytes = pdfOutStream.toByteArray();
        } catch (XDOException | FileNotFoundException ex) {
            Logger.getLogger(PrismProject.class.getName()).log(Level.SEVERE, null, ex);
        }
        return dataBytes;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.file;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author GF65
 */
public class StudentRoleDAO {

    public HashMap<String, String> loadStudentURLs() throws IOException {
        HashMap<String, String> mapUrls = new HashMap<>();
        InputStream is = null;
        InputStreamReader isr = null;
        BufferedReader br = null;

        try {
            is = StudentRoleDAO.class.getResourceAsStream("studentRole.txt");
            if (is != null) {
                isr = new InputStreamReader(is);
                br = new BufferedReader(isr);
                String line = null;
                while ((line = br.readLine()) != null) {
                    if (!line.isEmpty()) {
                        String[] part = line.split("=");
                        if (part.length == 2) {
                            mapUrls.put(part[0], part[1]);
                        }
                    }
                }
            }
        } finally {
            if (br != null) {
                br.close();
            }
            if (isr != null) {
                isr.close();
            }
            if (is != null) {
                is.close();
            }
        }
        return mapUrls;
    }
}

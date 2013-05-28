/*

   Derby - Class org.apache.derby.jdbc.ClientXADataSource

   Licensed to the Apache Software Foundation (ASF) under one or more
   contributor license agreements.  See the NOTICE file distributed with
   this work for additional information regarding copyright ownership.
   The ASF licenses this file to You under the Apache License, Version 2.0
   (the "License"); you may not use this file except in compliance with
   the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

*/

package org.apache.derby.jdbc;

import java.sql.SQLException;
import javax.sql.XAConnection;

/**
 * <p>
 * This datasource is suitable for a client/server use of Derby,
 * running on full Java SE 6 and higher, corresponding to JDBC 4.0 and higher.
 * </p>
 * An XADataSource is a factory for XAConnection objects.  It represents a
 * RM in a DTP environment.  An object that implements the XADataSource
 * interface is typically registered with a JNDI service provider.
 * <P>
 * ClientXADataSource automatically supports the correct JDBC specification version
 * for the Java Virtual Machine's environment.
 * <UL>
 * <LI> JDBC 4.2 - Java SE 8 </LI>
 * <LI> JDBC 4.1 - Java SE 7 </LI>
 * <LI> JDBC 4.0 - Java SE 6 </LI>
 * </UL>
 *
 * <P>ClientXADataSource is serializable and referenceable.</p>
 *
 * <P>See ClientDataSource for DataSource properties.</p>
 */
public class ClientXADataSource
    extends ClientDataSource implements ClientXADataSourceInterface {

    public static final String className__ = "org.apache.derby.jdbc.ClientXADataSource";

    // following serialVersionUID was generated by the JDK's serialver program
    // verify it everytime that ClientXADataSource is modified
    private static final long serialVersionUID = 7057075094707674880L;

    public ClientXADataSource() {
    }

    public XAConnection getXAConnection() throws SQLException {
        return getXAConnectionMinion();
    }

    public XAConnection getXAConnection(String user, String password) throws SQLException {
        return getXAConnectionMinion(user, password);
    }    
}

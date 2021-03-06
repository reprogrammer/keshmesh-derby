/*
    Derby Classname org.apache.derby.impl.services.jmxnone.NoManagementService
  
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at
 
       http://www.apache.org/licenses/LICENSE-2.0
 
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
  
 */

package org.apache.derby.impl.services.jmxnone;

import org.apache.derby.iapi.services.jmx.ManagementService;

/** 
 * Dummy management service for environments that do not support
 * JMX, such as JDK 1.4 and J2ME.
*/
public final class NoManagementService implements ManagementService {
    public NoManagementService() {
    }
    public Object registerMBean(final Object bean,
            final Class beanInterface,
            final String keyProperties)
    {
        return null;
    }
    public void unregisterMBean(Object mbeanIdentifier) {
    }
    public boolean isManagementActive() {
        return false;
    }
    public void startManagement() {
    }
    public void stopManagement() {
    }
    public String getSystemIdentifier() {
        return null;
    }
}
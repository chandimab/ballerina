/*
*  Copyright (c) 2017, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
*
*  WSO2 Inc. licenses this file to you under the Apache License,
*  Version 2.0 (the "License"); you may not use this file except
*  in compliance with the License.
*  You may obtain a copy of the License at
*
*    http://www.apache.org/licenses/LICENSE-2.0
*
*  Unless required by applicable law or agreed to in writing,
*  software distributed under the License is distributed on an
*  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
*  KIND, either express or implied.  See the License for the
*  specific language governing permissions and limitations
*  under the License.
*/

package org.ballerinalang.model.tree;

import java.util.List;

/**
 * @since 0.94
 */
public interface EnumNode extends TopLevelNode, AnnotatableNode {

    IdentifierNode getName();

    void setName(IdentifierNode name);

    List<? extends Enumerator> getEnumerators();

    void addEnumerator(Enumerator enumField);

    /**
     * @since 0.95
     */
    interface Enumerator extends Node {
        IdentifierNode getName();
    }
}

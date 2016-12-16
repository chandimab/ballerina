/*
 * Copyright (c) 2016, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.wso2.ballerina.core.runtime.registry;

import org.wso2.ballerina.core.model.Package;
import org.wso2.ballerina.core.model.Symbol;
import org.wso2.ballerina.core.model.types.CallableUnit;
import org.wso2.ballerina.core.model.types.CallableUnitType;
import org.wso2.ballerina.core.nativeimpl.AbstractNativeFunction;
import org.wso2.ballerina.core.nativeimpl.connectors.AbstractNativeAction;
import org.wso2.ballerina.core.runtime.internal.GlobalScopeHolder;

import java.util.HashMap;

/**
 * The place where all the package definitions are stored
 *
 * @since 1.0.0
 */
public class PackageRegistry {

    HashMap<String, Package> packages = new HashMap<String, Package>();

    private static PackageRegistry instance = new PackageRegistry();

    private PackageRegistry() {
    }

    public static PackageRegistry getInstance() {
        return instance;
    }

    public void registerPackage(Package aPackage) {
        packages.put(aPackage.getFullQualifiedName(), aPackage);
    }

    public Package getPackage(String fqn) {
        return packages.get(fqn);
    }

    /**
     * Register Native Function.
     *
     * @param function AbstractNativeFunction instance.
     */
    public void registerNativeFunction(AbstractNativeFunction function) {
        Package aPackage = packages
                .computeIfAbsent(function.getPackageName(), k -> new Package(function.getPackageName()));
        if (function.isPublic()) {
            aPackage.getPublicFunctions().put(function.getName(), function);
        } else {
            aPackage.getPrivateFunctions().put(function.getName(), function);
        }
        CallableUnitType callableUnitType = new CallableUnitType(CallableUnit.FUNCTION, function.getSymbolName());
        callableUnitType.setParamType(function.getSymbolName().getParameters());
        callableUnitType.setReturnType(function.getReturnTypes());
        GlobalScopeHolder.getInstance().insert(function.getSymbolName(), new Symbol(callableUnitType, 0));
    }

    /**
     * Register Native Action.
     *
     * @param action AbstractNativeAction instance.
     */
    public void registerNativeAction(AbstractNativeAction action) {
        Package aPackage = packages
                .computeIfAbsent(action.getPackageName(), k -> new Package(action.getPackageName()));
        aPackage.getActions().put(action.getName(), action);
        CallableUnitType callableUnitType = new CallableUnitType(CallableUnit.ACTION, action.getSymbolName());
        callableUnitType.setParamType(action.getSymbolName().getParameters());
        callableUnitType.setReturnType(action.getReturnTypes());
        GlobalScopeHolder.getInstance().insert(action.getSymbolName(), new Symbol(callableUnitType, 0));
    }

    /**
     * Unregister Native function.
     *
     * @param function AbstractNativeFunction instance.
     */
    public void unregisterNativeFunctions(AbstractNativeFunction function) {
        Package aPackage = packages.get(function.getPackageName());
        if (aPackage == null) {
            // Nothing to do.
            return;
        }
        if (function.isPublic()) {
            aPackage.getPublicFunctions().remove(function.getName());
        } else {
            aPackage.getPrivateFunctions().remove(function.getName());
        }
    }

    /**
     * Unregister Native Action.
     *
     * @param action AbstractNativeAction instance.
     */
    public void unregisterNativeActions(AbstractNativeAction action) {
        Package aPackage = packages.get(action.getPackageName());
        if (aPackage == null) {
            // Nothing to do.
            return;
        }
        aPackage.getActions().remove(action.getName());
    }
}
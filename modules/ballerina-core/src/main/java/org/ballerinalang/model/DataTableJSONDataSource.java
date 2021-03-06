/*
 *  Copyright (c) 2017, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package org.ballerinalang.model;

import org.ballerinalang.model.util.JsonGenerator;
import org.ballerinalang.model.util.JsonNode;
import org.ballerinalang.model.util.JsonNode.Type;
import org.ballerinalang.model.util.JsonParser;
import org.ballerinalang.model.values.BDataTable;
import org.ballerinalang.model.values.BJSON.JSONDataSource;

import java.io.IOException;

/**
 * {@link org.ballerinalang.model.values.BJSON.JSONDataSource} implementation for DataTable.
 *
 * @since 0.8.0
 */
public class DataTableJSONDataSource implements JSONDataSource {

    private BDataTable df;

    private JSONObjectGenerator objGen;

    private boolean isInTransaction;

    public DataTableJSONDataSource(BDataTable df, boolean isInTransaction) {
        this(df, new DefaultJSONObjectGenerator(), isInTransaction);
    }

    public DataTableJSONDataSource(BDataTable df, JSONObjectGenerator objGen, boolean isInTransaction) {
        this.df = df;
        this.objGen = objGen;
        this.isInTransaction = isInTransaction;
    }

    @Override
    public void serialize(JsonGenerator gen) throws IOException {
        gen.writeStartArray();
        while (this.df.hasNext(this.isInTransaction)) {
            this.objGen.transform(this.df).serialize(gen);
        }
        gen.writeEndArray();
        this.df.close(this.isInTransaction);
    }

    /**
     * Default {@link DataTableJSONDataSource.JSONObjectGenerator} implementation based
     * on the datatable's in-built column definition.
     */
    private static class DefaultJSONObjectGenerator implements JSONObjectGenerator {

        @Override
        public JsonNode transform(BDataTable df) throws IOException {
            JsonNode objNode = new JsonNode(Type.OBJECT);
            String name;
            for (ColumnDefinition col : df.getColumnDefs()) {
                name = col.getName();
                switch (col.getType()) {
                case STRING:
                    objNode.set(name, df.getString(name));
                    break;
                case INT:
                    objNode.set(name, df.getInt(name));
                    break;
                case FLOAT:
                    objNode.set(name, df.getFloat(name));
                    break;
                case BOOLEAN:
                    objNode.set(name, df.getBoolean(name));
                    break;
                case BLOB:
                    objNode.set(name, df.getBlob(name));
                    break;
                case ARRAY:
                    objNode.set(name, getDataArray(df, name));
                    break;
                case JSON:
                    objNode.set(name, JsonParser.parse(df.getString(name)));
                    break;
                case MAP:
                    /* not supported */
                    break;
                case XML:
                    /* not supported */
                    break;
                default:
                    objNode.set(name, df.getString(name));
                    break;
                }
            }
            return objNode;
        }

    }

    private static JsonNode getDataArray(BDataTable df, String columnName) {
        Object[] dataArray = df.getArray(columnName);
        int length = dataArray.length;
        JsonNode jsonArray = new JsonNode(Type.ARRAY);
        if (length > 0) {
            Object obj = dataArray[0];
            if (obj instanceof String) {
                for (Object value  : dataArray) {
                    jsonArray.add((String) value);
                }
            } else if (obj instanceof Boolean) {
                for (Object value  : dataArray) {
                    jsonArray.add((Boolean) value);
                }
            } else if (obj instanceof Integer) {
                for (Object value  : dataArray) {
                    jsonArray.add((int) value);
                }
            } else if (obj instanceof Long) {
                for (Object value  : dataArray) {
                    jsonArray.add((long) value);
                }
            } else if (obj instanceof Float) {
                for (Object value  : dataArray) {
                    jsonArray.add((float) value);
                }
            } else if (obj instanceof Double) {
                for (Object value  : dataArray) {
                    jsonArray.add((double) value);
                }
            }
        }
        return  jsonArray;
    }

    /**
     * This represents the logic that will transform the current entry of a
     * data table to a {@link JsonNode}.
     */
    public static interface JSONObjectGenerator {

        /**
         * Converts the current position of the given datatable to a JSON object.
         *
         * @param datatable The datatable that should be used in the current position
         * @return The generated JSON object
         * @throws IOException for json reading/serializing errors
         */
        JsonNode transform(BDataTable datatable) throws IOException;

    }

}

<template>
  <div>
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-default">
      <!-- Card stats -->
      <!-- <b-row>
        <b-col xl="3" md="6">
          <stats-card title="Total traffic"
                      type="gradient-red"
                      sub-title="350,897"
                      icon="ni ni-active-40"
                      class="mb-4">

            <template slot="footer">
              <span class="text-success mr-2">3.48%</span>
              <span class="text-nowrap">Since last month</span>
            </template>
          </stats-card>
        </b-col>
        <b-col xl="3" md="6">
          <stats-card title="Total traffic"
                      type="gradient-orange"
                      sub-title="2,356"
                      icon="ni ni-chart-pie-35"
                      class="mb-4">

            <template slot="footer">
              <span class="text-success mr-2">12.18%</span>
              <span class="text-nowrap">Since last month</span>
            </template>
          </stats-card>
        </b-col>
        <b-col xl="3" md="6">
          <stats-card title="Sales"
                      type="gradient-green"
                      sub-title="924"
                      icon="ni ni-money-coins"
                      class="mb-4">

            <template slot="footer">
              <span class="text-danger mr-2">5.72%</span>
              <span class="text-nowrap">Since last month</span>
            </template>
          </stats-card>

        </b-col>
        <b-col xl="3" md="6">
          <stats-card title="Performance"
                      type="gradient-info"
                      sub-title="49,65%"
                      icon="ni ni-chart-bar-32"
                      class="mb-4">

            <template slot="footer">
              <span class="text-success mr-2">54.8%</span>
              <span class="text-nowrap">Since last month</span>
            </template>
          </stats-card>
        </b-col>
      </b-row> -->
    </base-header>
    <b-container fluid="xl">
      <b-row v-if="isSelected">
        <b-col cols="4">
          <light-table v-bind:isClicked="isSelected" v-on:clickRow="clickOn" />
        </b-col>
        <b-col cols="7">
          <detail v-bind:pid="selPid" v-on:goBack="clickOff" />
        </b-col>
      </b-row>
      <b-row v-else>
        <b-col>
          <light-table v-bind:isClicked="isSelected" v-on:clickRow="clickOn" />
        </b-col>
      </b-row>
    </b-container>
    <!-- <dark-table></dark-table> -->
  </div>
</template>
<script>
import {
  Dropdown,
  DropdownItem,
  DropdownMenu,
  Table,
  TableColumn
} from "element-ui";
import LightTable from "./Tables/LightTable";
import DarkTable from "./Tables/DarkTable";
import Detail from "./Posting/Detail";

export default {
  components: {
    LightTable,
    DarkTable,
    Detail,
    [Dropdown.name]: Dropdown,
    [DropdownItem.name]: DropdownItem,
    [DropdownMenu.name]: DropdownMenu,
    [Table.name]: Table,
    [TableColumn.name]: TableColumn
  },
  data() {
    return {
      isSelected: false,
      tWidth: "550px",
      selPid: ""
    };
  },
  methods: {
    clickOn: function(pid) {
      this.isSelected = true;
      this.selPid = pid;
    },
    clickOff: function() {
      this.isSelected = false;
    }
  }
};
</script>
<style>
.el-table.table-dark {
  background-color: #172b4d;
  color: #f8f9fe;
}

.el-table.table-dark th,
.el-table.table-dark tr {
  background-color: #172b4d;
}

.el-table.table-dark td,
.el-table.table-dark th.is-leaf {
  border-bottom: none;
}

body {
  -ms-overflow-style: none;
}
::-webkit-scrollbar {
  display: none;
}
.box {
  -ms-overflow-style: none;
}
.box::-webkit-scrollbar {
  display: none;
}
</style>

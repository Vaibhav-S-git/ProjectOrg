import LightningDatatable from 'lightning/datatable';
import CustomPicklist from './picklistColumn.html';
export default class DataTableComp extends LightningDatatable {
  static customTypes = {
    picklistColumn: {
      template: CustomPicklist,
      standardCellLayout: true,
      typeAttributes: ['label', 'placeholder', 'options', 'value', 'name', 'id']
    }
  };
}
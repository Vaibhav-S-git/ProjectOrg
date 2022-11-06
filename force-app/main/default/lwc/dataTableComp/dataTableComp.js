import LightningDatatable from 'lightning/datatable';
import picklistColumn from './picklistColumn.html';
export default class DataTableComp extends LightningDatatable  {
  static customTypes = {
    picklistColumn: {
        template: picklistColumn,
        standardCellLayout: true,
        typeAttributes: ['label', 'placeholder', 'options', 'value', 'context', 'variant','name']
    }
};
}